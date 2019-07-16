module ApplicationHelper
  include SessionsHelper

  def title page_title
    base_title = I18n.t "title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def link_to_add_row name, field, association, **args
    obj = field.object.send(association).klass.new
    id = obj.object_id
    fields = field.fields_for(association, obj, child_index: id) do |builder|
      render association.to_s.singularize, f: builder
    end
    link_to name, "", class: "add_fields " + args[:class],
      data: {id: id, fields: fields.delete("\n")}
  end

  def index_number index, page
    index += 1
    page.present? ? Settings.per_page_default * (page.to_i - 1) + index : index
  end

  def finish_subj_user subject_user_id
    SubjectUser.find_by(id: subject_user_id).update_attribute(:status, 2)
  end

  def sub_task_field form
    sub_task = form.object.tasks.build
    form.fields_for :tasks, sub_task,
      child_index: "idcheck" do |builder|
      render "supervisors/subjects/task", f: builder
    end
  end
end
