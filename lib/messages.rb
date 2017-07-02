module Messages

  def get_messages(page_number = false)
    if page_number
      response = self.class.get("/message_threads", headers: { "authorization" => @auth_token}, body: {"page" => page_number})
    else
      response = self.class.get("/message_threads", headers: { "authorization" => @auth_token})
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def create_message(recipient_id, subject, message)
    options = {"sender" => self.get_me[:email], "recipient_id" => recipient_id, "subject" => subject, "stripped-text" => message }
    response = self.class.post("/messages", headers: {"authorization" => @auth_token}, body: options)
  end
end
