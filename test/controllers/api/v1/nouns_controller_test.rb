require "controllers/api/v1/test"

class Api::V1::NounsControllerTest < Api::Test
def setup
  # See `test/controllers/api/test.rb` for common set up for API tests.
  super

  @noun = build(:noun, team: @team)
  @other_nouns = create_list(:noun, 3)

  @another_noun = create(:noun, team: @team)

  # 🚅 super scaffolding will insert file-related logic above this line.
  @noun.save
  @another_noun.save

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
def assert_proper_object_serialization(noun_data)
  # Fetch the noun in question and prepare to compare it's attributes.
  noun = Noun.find(noun_data["id"])

  assert_equal_or_nil noun_data['name'], noun.name
  # 🚅 super scaffolding will insert new fields above this line.

  assert_equal noun_data["team_id"], noun.team_id
end

test "index" do
  # Fetch and ensure nothing is seriously broken.
  get "/api/v1/teams/#{@team.id}/nouns", params: {access_token: access_token}
  assert_response :success

  # Make sure it's returning our resources.
  noun_ids_returned = response.parsed_body.map { |noun| noun["id"] }
  assert_includes(noun_ids_returned, @noun.id)

  # But not returning other people's resources.
  assert_not_includes(noun_ids_returned, @other_nouns[0].id)

  # And that the object structure is correct.
  assert_proper_object_serialization response.parsed_body.first
end

test "show" do
  # Fetch and ensure nothing is seriously broken.
  get "/api/v1/nouns/#{@noun.id}", params: {access_token: access_token}
  assert_response :success

  # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # Also ensure we can't do that same action as another user.
  get "/api/v1/nouns/#{@noun.id}", params: {access_token: another_access_token}
  assert_response :not_found
end

test "create" do
  # Use the serializer to generate a payload, but strip some attributes out.
  params = {access_token: access_token}
  noun_data = JSON.parse(build(:noun, team: nil).api_attributes.to_json)
  noun_data.except!("id", "team_id", "created_at", "updated_at")
  params[:noun] = noun_data

  post "/api/v1/teams/#{@team.id}/nouns", params: params
  assert_response :success

  # # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # Also ensure we can't do that same action as another user.
  post "/api/v1/teams/#{@team.id}/nouns",
    params: params.merge({access_token: another_access_token})
  assert_response :not_found
end

test "update" do
  # Post an attribute update ensure nothing is seriously broken.
  put "/api/v1/nouns/#{@noun.id}", params: {
    access_token: access_token,
    noun: {
      name: 'Alternative String Value',
      # 🚅 super scaffolding will also insert new fields above this line.
    }
  }

  assert_response :success

  # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # But we have to manually assert the value was properly updated.
  @noun.reload
  assert_equal @noun.name, 'Alternative String Value'
  # 🚅 super scaffolding will additionally insert new fields above this line.

  # Also ensure we can't do that same action as another user.
  put "/api/v1/nouns/#{@noun.id}", params: {access_token: another_access_token}
  assert_response :not_found
end

test "destroy" do
  # Delete and ensure it actually went away.
  assert_difference("Noun.count", -1) do
    delete "/api/v1/nouns/#{@noun.id}", params: {access_token: access_token}
    assert_response :success
  end

  # Also ensure we can't do that same action as another user.
  delete "/api/v1/nouns/#{@another_noun.id}", params: {access_token: another_access_token}
  assert_response :not_found
end
end
