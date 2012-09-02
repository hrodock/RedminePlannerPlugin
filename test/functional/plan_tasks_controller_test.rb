require File.dirname(__FILE__) + '/../test_helper'

class PlanTasksControllerTest < ActionController::TestCase
  fixtures :projects, :users, :roles, :trackers, :members, :member_roles,
    :enabled_modules, :plan_tasks

  setup do
    @plan_task = plan_tasks(:one)

    @request.session[:user_id] = 2
    Role.find(1).add_permission! :planner_admin
    Project.find(1).enabled_module_names = [:planner]
  end

  test "should get index" do
    get :index, :project_id => 1

    assert_response :success
    assert_template 'index'
    assert_equal PlanTask.all_project_tasks(1), assigns(:plan_tasks)
  end

  test "should get new" do
    get :new, :project_id => 1

    assert_response :success
    assert_template 'new'
  end

  test "should create plan_task" do
    assert_difference('PlanTask.count') do
      post :create, :project_id => 1, :plan_task => {
        :owner_id => @plan_task.owner_id,
        :name => 'New name',
        :description => 'New descr',
        :wbs => 'New WBS',
        :parent_task => @plan_task.parent_task
      }
    end

    assert_redirected_to project_plan_tasks_url(assigns(:project))

    tmp = assigns(:plan_task)
    assert_equal 'New name', tmp.name
    assert_equal 'New descr', tmp.description
    assert_equal 'New WBS', tmp.wbs
  end

  test "should show plan_task" do
    get :show, :id => @plan_task.id

    assert_response :success
    assert_template 'show'
    assert_equal @plan_task, assigns(:plan_task)
  end

  test "should get edit" do
    get :edit, :id => @plan_task.id

    assert_response :success
    assert_template 'edit'
    assert_equal @plan_task, assigns(:plan_task)
  end

  test "should update plan_task" do
    put :update, :id => @plan_task.id, :plan_task => {
      :owner_id => @plan_task.owner_id,
      :name => 'New name',
      :description => 'New descr',
      :wbs => 'New WBS',
      :parent_task => @plan_task.parent_task
    }

    assert_redirected_to project_plan_tasks_url(assigns(:project))

    tmp = PlanTask.find(@plan_task.id)
    assert_equal 'New name', tmp.name
    assert_equal 'New descr', tmp.description
    assert_equal 'New WBS', tmp.wbs
  end

  test "should destroy plan_task" do
    assert_difference('PlanTask.count', -1) do
      delete :destroy, :id => @plan_task
    end

    assert_redirected_to project_plan_tasks_path(@plan_task.project)
  end
end
