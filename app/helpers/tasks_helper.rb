module TasksHelper
  def student_action(task)
    status = task.status
    project = task.project
    if status == "new"
      link_to 'Open', open_project_task_path(project, task)
    elsif status == "open"
      link_to 'Resolve', resolve_project_task_path(project, task)
    end
  end
end
