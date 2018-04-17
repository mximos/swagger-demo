# spec/integration/pets_spec.rb
require 'swagger_helper'

describe 'Pets API' do

  path '/api/v1/pets' do

    post 'Creates a pet' do
      tags 'Pets'
      consumes 'application/json', 'application/xml'
      parameter name: :pet, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          photo_url: { type: :string },
          status: { type: :string }
        },
        required: [ 'name', 'status' ]
      }

      response '201', 'pet created' do
        let(:pet) { { name: 'Dodo', status: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:pet) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/pets/{id}' do

    get 'Retrieves a pet' do
      tags 'Pets'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            photo_url: { type: :string },
            status: { type: :string }
          },
          required: [ 'id', 'name', 'status' ]

        let(:id) { Pet.create(name: 'foo', status: 'bar', photo_url: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'pet not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end