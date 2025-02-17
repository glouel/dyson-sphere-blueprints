class Attachment::PromoteJob < ApplicationJob
  def perform(record, name, file_data)
    puts "Creating derivatives for #{record.class} # #{record.id}"
    attacher = Shrine::Attacher.retrieve(model: record, name: name, file: file_data)
    attacher.create_derivatives if record.is_a?(Blueprint) || record.is_a?(Picture)
    attacher.atomic_promote
  rescue Shrine::AttachmentChanged, ActiveRecord::RecordNotFound
    # attachment has changed or the record has been deleted, nothing to do
  end
end