require 'rails_helper'

RSpec.describe "repositories/edit", type: :view do
  let(:repository) {
    Repository.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:repository, repository)
  end

  it "renders the edit repository form" do
    render

    assert_select "form[action=?][method=?]", repository_path(repository), "post" do

      assert_select "input[name=?]", "repository[name]"
    end
  end
end
