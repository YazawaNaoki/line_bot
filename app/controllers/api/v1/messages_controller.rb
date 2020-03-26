module Api
  module V1
    class MessagesController < ApplicationController
      require 'line/bot'
      protect_from_forgery

      def create

        message = Message.new(message_params)

        if message.save
          render json: { status: 'SUCCESS', message: 'Saved message.', data: message }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Message not saved.', data: message.errors }, status: :unprocessable_entity
        end

        msg = {
          type: 'text',
          text: message.content,
          "sender": {
            "name": "Cony",
            "iconUrl": "https://i.picsum.photos/id/1039/200/200.jpg"
          }
        }
        client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
          config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
        }
        response = client.push_message(msg)
        p response

      end

      private
      def message_params
        params.permit(:content)
      end
    end
  end
end
