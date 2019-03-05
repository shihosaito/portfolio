require 'test_helper'

class Admin::AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_albums_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_albums_edit_url
    assert_response :success
  end

end
