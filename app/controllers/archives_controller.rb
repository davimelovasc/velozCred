class ArchivesController < ApplicationController
  def new
    @archive = Archive.new
  end

  def create

    archives = params[:archive]

    if archives["total_production"] != nil && archives["register"] != nil
      total_production = archives["total_production"]
      register = archives["register"]


      database1 = Mdb.open(@register.tempfile)
      database2 = Mdb.open(@total_production.tempfile)

      if database1 != nil && database2 != nil
        AgentController.update_db(database1, database2)

      end

    end

    private
    def archive_params
      params.require(:archive).permit(:total_production, :register)
    end

  end
