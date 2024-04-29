require "controllers/api/v1/test"

class Api::V1::ActsControllerTest < Api::Test
def setup
  # See `test/controllers/api/test.rb` for common set up for API tests.
  super

  @verb = create(:verb, team: @team)
  @act = build(:act, verb: @verb)
  @other_acts = create_list(:act, 3)

  @another_act = create(:act, verb: @verb)

  # 🚅 super scaffolding will insert file-related logic above this line.
  @act.save
  @another_act.save

  @original_hide_things = ENV["HIDE_THINGS"]
  ENV["HIDE_THINGS"] = "false"
  Rails.application.reload_routes!
end

def teardown
  super
  ENV["HIDE_THINGS"] = @original_hide_things
  Rails.application.reload_routes!
end

# This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
# data we were previously providing to users _will_ break the test suite.
def assert_proper_object_serialization(act_data)
  # Fetch the act in question and prepare to compare it's attributes.
  act = Act.find(act_data["id"])

  assert_equal_or_nil act_data['name'], act.name
  assert_equal_or_nil act_data['calling_verb_id'], act.calling_verb_id
  # 🚅 super scaffolding will insert new fields above this line.

  assert_equal act_data["verb_id"], act.verb_id
end

test "index" do
  # Fetch and ensure nothing is seriously broken.
  get "/api/v1/verbs/#{@verb.id}/acts", params: {access_token: access_token}
  assert_response :success

  # Make sure it's returning our resources.
  act_ids_returned = response.parsed_body.map { |act| act["id"] }
  assert_includes(act_ids_returned, @act.id)

  # But not returning other people's resources.
  assert_not_includes(act_ids_returned, @other_acts[0].id)

  # And that the object structure is correct.
  assert_proper_object_serialization response.parsed_body.first
end

test "show" do
  # Fetch and ensure nothing is seriously broken.
  get "/api/v1/acts/#{@act.id}", params: {access_token: access_token}
  assert_response :success

  # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # Also ensure we can't do that same action as another user.
  get "/api/v1/acts/#{@act.id}", params: {access_token: another_access_token}
  assert_response :not_found
end

test "create" do
  # Use the serializer to generate a payload, but strip some attributes out.
  params = {access_token: access_token}
  act_data = JSON.parse(build(:act, verb: nil).api_attributes.to_json)
  act_data.except!("id", "verb_id", "created_at", "updated_at")
  params[:act] = act_data

  post "/api/v1/verbs/#{@verb.id}/acts", params: params
  assert_response :success

  # # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # Also ensure we can't do that same action as another user.
  post "/api/v1/verbs/#{@verb.id}/acts",
    params: params.merge({access_token: another_access_token})
  assert_response :not_found
end

test "update" do
  # Post an attribute update ensure nothing is seriously broken.
  put "/api/v1/acts/#{@act.id}", params: {
    access_token: access_token,
    act: {
      name: 'Alternative String Value',
      # 🚅 super scaffolding will also insert new fields above this line.
    }
  }

  assert_response :success

  # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # But we have to manually assert the value was properly updated.
  @act.reload
  assert_equal @act.name, 'Alternative String Value'
  # 🚅 super scaffolding will additionally insert new fields above this line.

  # Also ensure we can't do that same action as another user.
  put "/api/v1/acts/#{@act.id}", params: {access_token: another_access_token}
  assert_response :not_found
end

test "destroy" do
  # Delete and ensure it actually went away.
  assert_difference("Act.count", -1) do
    delete "/api/v1/acts/#{@act.id}", params: {access_token: access_token}
    assert_response :success
  end

  # Also ensure we can't do that same action as another user.
  delete "/api/v1/acts/#{@another_act.id}", params: {access_token: another_access_token}
  assert_response :not_found
end
end
