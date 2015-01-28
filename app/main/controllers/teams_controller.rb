class TeamsController < Volt::ModelController
  model :store # allows us to use _teams instead of page._teams

  def index
  end

  def show
    _teams.find(_id: params._id).then do |results|
      self.model = results[0]
    end
  end

  private

  def add_team
    _teams << { name: page._new_team }
    page._new_team = ''
  end

  def remove_team(team)
    team_goals = _goals.find(team_id: team._id)
    team_goals.each {|goal| _goals.delete(goal) }
    _teams.delete(team)
  end

  def add_goal
    _goals << {name: page._goal_name, team_id: self.model.__id}
    page._goal_name = ''
  end

  def remove_goal(goal)
    _goals.delete(goal)
  end

end
