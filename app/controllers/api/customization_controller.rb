class Api::CustomizationController < ApplicationController
  def create
    permitted_params = params.permit(
      :portion,
      requests: [],
      ingredients: [:id, :name, :calories_per_100g, :protein_per_100g, :quantity, :unit]
    )
    response = OpenaiService.customization(permitted_params[:ingredients], permitted_params[:portion],permitted_params[:requests])
    cleaned_content = response
    .gsub(/```json\n?/, '')  # Remove ```json
    .gsub(/```/, '')
    .gsub('#<ActionController::Parameters', '')
    .gsub('permitted: true>', '')
    .gsub('\\"', '"')         # Remove remaining ```
    .gsub(/=>/, ':')         # Convert Ruby hash syntax to JSON
    .gsub(/\s+/, ' ')        # Normalize whitespace
    .strip                   # Remove leading/trailing whitespace
    cleaned_response = JSON.parse(cleaned_content)
    render json: cleaned_response, status: :ok
        # Try to parse the response as JSON
  #   begin
  #     # Remove any markdown formatting if present
  #     response = response.gsub(/```json\n?/, '').gsub(/```/, '')
  #     JSON.parse(response.strip)
  #   rescue JSON::ParserError => e
  #     Rails.logger.error "Failed to parse OpenAI response: #{response}"
  #     raise "Failed to parse customized ingredients"
  #   end
  end

end
