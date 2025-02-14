class Api::CustomizationController < ApplicationController
  def create
    permitted_params = params.permit(
      :portion,
      :initialCalories,
      :initialProtein,
      requests: [],
      ingredients: [[:name, :quantity]]
    )
    response = OpenaiService.customization(permitted_params[:ingredients], permitted_params[:portion],permitted_params[:requests], permitted_params[:initialCalories], permitted_params[:initialProtein])
    Rails.logger.info(response)
    cleaned_content = response
    .gsub(/```json\n?/, '')  # Remove ```json
    .gsub(/```/, '')
    # .gsub('#<ActionController::Parameters', '')
    # .gsub('permitted: true>', '')
    # .gsub('\\"', '"')         # Remove remaining ```
    # .gsub(/=>/, ':')         # Convert Ruby hash syntax to JSON
    # .gsub(/\s+/, ' ')        # Normalize whitespace
    # .strip                   # Remove leading/trailing whitespace
    cleaned_response = JSON.parse(cleaned_content)
    Rails.logger.info(cleaned_response)
    render json: cleaned_response, status: :ok
  end

end
