require "controllers/api/v1/test"

class Api::V1::OperandsControllerTest < Api::Test
def setup
  # See `test/controllers/api/test.rb` for common set up for API tests.
  super

  @verb = create(:verb, team: @team)
  @act = create(:act, verb: @verb)
  @operand = build(:operand, act: @act)
  @other_operands = create_list(:operand, 3)

  @another_operand = create(:operand, act: @act)

  # 🚅 super scaffolding will insert file-related logic above this line.
  @operand.save
  @another_operand.save

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
def assert_proper_object_serialization(operand_data)
  # Fetch the operand in question and prepare to compare it's attributes.
  operand = Operand.find(operand_data["id"])

  assert_equal_or_nil operand_data['name'], operand.name
  assert_equal_or_nil operand_data['noun_id'], operand.noun_id
  # 🚅 super scaffolding will insert new fields above this line.

  assert_equal operand_data["act_id"], operand.act_id
end

test "index" do
  # Fetch and ensure nothing is seriously broken.
  get "/api/v1/acts/#{@act.id}/operands", params: {access_token: access_token}
  assert_response :success

  # Make sure it's returning our resources.
  operand_ids_returned = response.parsed_body.map { |operand| operand["id"] }
  assert_includes(operand_ids_returned, @operand.id)

  # But not returning other people's resources.
  assert_not_includes(operand_ids_returned, @other_operands[0].id)

  # And that the object structure is correct.
  assert_proper_object_serialization response.parsed_body.first
end

test "show" do
  # Fetch and ensure nothing is seriously broken.
  get "/api/v1/operands/#{@operand.id}", params: {access_token: access_token}
  assert_response :success

  # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # Also ensure we can't do that same action as another user.
  get "/api/v1/operands/#{@operand.id}", params: {access_token: another_access_token}
  assert_response :not_found
end

test "create" do
  # Use the serializer to generate a payload, but strip some attributes out.
  params = {access_token: access_token}
  operand_data = JSON.parse(build(:operand, act: nil).api_attributes.to_json)
  operand_data.except!("id", "act_id", "created_at", "updated_at")
  params[:operand] = operand_data

  post "/api/v1/acts/#{@act.id}/operands", params: params
  assert_response :success

  # # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # Also ensure we can't do that same action as another user.
  post "/api/v1/acts/#{@act.id}/operands",
    params: params.merge({access_token: another_access_token})
  assert_response :not_found
end

test "update" do
  # Post an attribute update ensure nothing is seriously broken.
  put "/api/v1/operands/#{@operand.id}", params: {
    access_token: access_token,
    operand: {
      name: 'Alternative String Value',
      # 🚅 super scaffolding will also insert new fields above this line.
    }
  }

  assert_response :success

  # Ensure all the required data is returned properly.
  assert_proper_object_serialization response.parsed_body

  # But we have to manually assert the value was properly updated.
  @operand.reload
  assert_equal @operand.name, 'Alternative String Value'
  # 🚅 super scaffolding will additionally insert new fields above this line.

  # Also ensure we can't do that same action as another user.
  put "/api/v1/operands/#{@operand.id}", params: {access_token: another_access_token}
  assert_response :not_found
end

test "destroy" do
  # Delete and ensure it actually went away.
  assert_difference("Operand.count", -1) do
    delete "/api/v1/operands/#{@operand.id}", params: {access_token: access_token}
    assert_response :success
  end

  # Also ensure we can't do that same action as another user.
  delete "/api/v1/operands/#{@another_operand.id}", params: {access_token: another_access_token}
  assert_response :not_found
end
end
