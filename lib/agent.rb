class Agent
  def initialize
    Travis.access_token = ENV['TRAVIS_TOKEN']
  end

  def save_all(slug)
    t_repo = Travis::Repository.find(slug)
    ActiveRecord::Base.transaction do
      repo = save_repo(t_repo)
      t_repo.builds.each do |t_build|
        build = save_build(repo, t_build)
        t_build.jobs.each do |t_job|
          save_job(build, t_job)
        end
      end
    end
  end

  def save_repo(t_repo)
    if repo = Repository.where(slug: t_repo.slug).first
      repo.update(t_repo.to_h.slice(*%w(private description github_language)))
    else
      repo = Repository.create(t_repo.to_h.slice(*%w(slug private description github_language)))
    end
    repo
  end

  def save_build(repo, t_build)
    build_params = t_build.to_h.slice(*%w(commit_id number pull_request_id state started_at finished_at duration))
    if build = repo.builds.where(number: t_build.number).first
      build.update(build_params)
    else
      build = repo.builds.build(build_params)
      build.save
    end
    build
  end

  def save_job(build, t_job)
    job_params = t_job.to_h.slice(*%w(log_id number state started_at finished_at queue))
    job_params.merge!(t_job.to_h['config'].slice('rvm', 'env'))
    job_params['duration'] = (t_job.finished_at - t_job.started_at).to_i if t_job.finished_at && t_job.started_at
    if job = build.jobs.where(number: t_job.number).first
      job.update(job_params)
    else
      job = build.jobs.build(job_params)
      job.save
    end
    job
  end
end
