require 'test_helper'

class RailsPerformanceControllerTest < ActionDispatch::IntegrationTest
  test "should get home page" do
    setup_db
    get '/'
    assert_response :success
  end

  test "should get index" do
    setup_db
    get '/rails/performance'
    assert_response :success
  end

  test "should get index with params" do
    setup_db
    get '/rails/performance', params: { controller_eq: "Home", action_eq: 'index' }
    assert_response :success
  end

  test "should get summary with params" do
    setup_db
    get '/rails/performance/summary', params: { controller_eq: "Home", action_eq: 'index' }, xhr: true
    assert_response :success

    get '/rails/performance/summary', params: { controller_eq: "Home", action_eq: 'index' }, xhr: false
    assert_response :success
  end

  test "should get crashes with params" do
    setup_db
    get '/rails/performance/crashes'
    assert_response :success
  end

  test "should get requests with params" do
    setup_db
    get '/rails/performance/requests'
    assert_response :success
  end

  test "should get recent with params" do
    setup_db
    get '/rails/performance/recent'
    assert_response :success
  end

  test "should get jobs with params" do
    setup_db
    setup_job_db
    get '/rails/performance/jobs'
    assert_response :success
  end

  test "should get trace with params" do
    setup_db(dummy_event(request_id: "112233"))
    RP::Utils.log_trace_in_redis("112233", [
      {group: :db, sql: "select", duration: 111},
      {group: :view, message: "rendering (Duration: 11.3ms)"}
    ])

    get '/rails/performance/trace/112233', xhr: true
    assert_response :success

    get '/rails/performance/trace/112233', xhr: false
    assert_response :success
  end
end