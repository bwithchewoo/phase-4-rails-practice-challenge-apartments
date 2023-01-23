class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

      def create
          lease = Lease.create!(lease_params)
          render json: lease, status: :created
      end

      def index
          render json: Lease.all
      end

      def destroy
          lease = find_lease
          lease.destroy
      end

      private

      def lease_params
          params.permit(:rent)
      end

      def find_lease
          Lease.find(params[:id])
      end

      def render_record_not_found_response(invalid)
          render json: {errors: invalid.record.errors.full_messages}, status: :not_found
      end

      def unprocessable_entity_response(invalid)
          render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
      end

  end
