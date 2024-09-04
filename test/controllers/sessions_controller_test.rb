require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
    setup do
        @example_user = users(:example_user)
    end

    test "should_get_registration_page" do
        get registration_path
        assert_response :success
    end

    test "should_post_registration_page" do
        get registration_path
        assert_response :success
        post registration_path, params: { username: @example_user.username, password: @example_user.password }
        assert_response :success
    end

    test "should_not_successfully_register" do
        get login_path
        assert_response :success
        post login_path, params: { username: @example_user.username, password: @example_user.password, email: @example_user.email }
        assert_response :not_found
    end

    test "should_get_presentation_page" do
        get presentation_path
        assert_response :success
    end

end
