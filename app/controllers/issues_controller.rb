class IssuesController < ApplicationController
  before_action :set_task, only: %i[ index new create show edit update destroy]
  before_action :set_issue, only: %i[ show edit update destroy ]

  # GET /issues or /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1 or /issues/1.json
  def show
    @task = Task.find(params[:task_id])
    @issue = @task.issues.find(params[:id])
  end

  # GET /issues/new
  def new
    @issue = @task.issues.build
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues or /issues.json
  def create
    @issue = @task.issues.build(issue_params)

    if @issue.save
      redirect_to task_issue_path(@task, @issue), notice: 'Issue was successfull'
    else
      render :new
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to issue_url(@issue), notice: "Issue was successfully updated." }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue.destroy!

    respond_to do |format|
      format.html { redirect_to issues_url, notice: "Issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_issue
      @issue = @task.issues.find(params[:id])
    end

    def set_task
      @task = Task.find(params[:task_id])
    end

    # Only allow a list of trusted parameters through.
    def issue_params
      params.require(:issue).permit(:title, :description, :status)
    end
end
