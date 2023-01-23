class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_invalid_response

      def index
          render json: Apartment.all
      end

      def show
          apartment = find_apartment
          render json: apartment
      end

      def create
          apartment = Apartment.create!(apartment_params)
          render json: apartment, status: :created
      end

      def destroy
          apartment = find_apartment
          apartment.destroy
          head :no_content
      end

      def update
          apartment = find_apartment
          apartment.update!(apartment_params)
          render json: apartment
      end

      private
      def apartment_params
          params.permit(:number)
      end

      def find_apartment
          Apartment.find(params[:id])
      end

      def render_unprocessable_entity_response(invalid)
          render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
      end

      def render_record_invalid_response(invalid)
          render json: {errors: invalid.record.errors.full_messages}, status: :not_found
      end
  end
