module Checkpoints
  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    options = {"assignment_branch" => assignment_branch, "assignment_commit_link" => assignment_commit_link,
    "checkpoint_id" => checkpoint_id, "comment" => comment, "enrollment_id" => self.get_me[:current_enrollment][:id]}

    response = self.class.post('/checkpoint_submissions', :body => options)
    JSON.parse(response.body, symbolize_names: true)
  end
end
