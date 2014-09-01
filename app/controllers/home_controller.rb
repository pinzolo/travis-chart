class HomeController < ApplicationController
  def index
    @repo = Repository.where(slug: 'pinzolo/redmine_mx').first
    @rvms = @repo.builds.map { |build| build.jobs.map(&:rvm) }.flatten.uniq.sort
    @envs = @repo.builds.map { |build| build.jobs.map(&:env) }.flatten.uniq.sort
    @env = params[:env].presence || @envs.first
    @duration_table = {}
    @repo.builds.sort_by { |build| build.number.to_i }.reverse.each do |build|
      @duration_table[build.number] = {}
      build.jobs.select { |job| job.env == @env }.each do |job|
        @duration_table[build.number][job.rvm] = job.duration
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @durations }
    end
  end
end
