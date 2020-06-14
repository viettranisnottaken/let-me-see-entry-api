module Api::V1
  class UsersController < BaseController
    before_action :find_user, except: %i[index new create]
    before_action :get_all_schools, only: %i[new edit]

    def index
      users = User.by_name(params[:user_name])
            .by_school_name(params[:school_name])
            .by_gender(params[:gender])
            .birthdate_between(params[:from], params[:to])
            .page(params[:page])
            .per(params[:per])

      render json: users, each_serializer: UserSerializer
    end

    def show

    end

    def new
      render json: @schools, each_serializer: SchoolSerializer
    end

    def create
      user = User.new(user_params)
      if user.save!
        render json: { user_created: true }, status: 201
      else
        render json: { user_created: false }
      end
    end

    def edit
      render json: {
        user:ActiveModelSerializers::SerializableResource.new(@user, serializer: UserSerializer),
        schools: ActiveModelSerializers::Adapter::Attributes.new(
          ActiveModel::Serializer::CollectionSerializer.new(@schools, each_serializer: SchoolSerializer)
        )
      }
    end

    def update
      if @user.update!(user_params)
        render json: { user_updated: true }
      else
        render json: { user_updated: false }
      end
    end

    def destroy
      @user.destroy
      render json: { user_destroyed: true }
    end

    private

    def user_params
      params.require(:user).permit(:name, :gender, :birthdate, :school_id)
    end

    def find_user
      @user = User.find(params[:id])
    end

    def get_all_schools
      @schools = School.all
    end
  end
end
