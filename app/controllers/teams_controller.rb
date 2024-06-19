class TeamsController < ApplicationController
  before_action :set_client

  def index
    @team = Team.where(client_id: params[:client_id]).includes(user: { avatar_attachment: :blob })
    authorize @team
  end

  def new
    @users = User.all
    @team = Team.new
    authorize @team
  end

  def create
    @team_service = TeamService.new(teams_params, current_user)
    @member = @team_service.create
    authorize @member

    message = "You added a new member to the #{@client.name} team."
    handle_turbo_response(@member.persisted?, @member, message)
  end

  def destroy
    @member = Team.find(params[:id])
    authorize @member

    message = "#{t "team.#{action_name}.success"} from the #{@client.name} team."
    handle_turbo_response(@member.destroy, @member, message)
  end

  private

  def initialize_team_service; end

  def set_client
    @client = Client.find(params[:client_id])
  end

  def teams_params
    params.require(:team).permit(:client_id, :user_id)
  end
end
