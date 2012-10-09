require File.dirname(__FILE__) + '/../../test_helper'

class RoutingPlanChartsTest < ActionController::IntegrationTest
  def test_planner_scoped_under_project
    assert_routing(
        { :method => 'get', :path => "/projects/foo/planner/user/3" },
        { :controller => 'plan_charts', :action => 'show_user',
          :project_id => 'foo', :id => '3' })
  end
end