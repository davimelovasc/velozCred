class ArchivesController < ApplicationController
  def new
    @archive = Archive.new
  end

  def create

    archives = params[:archive]

    if archives != nil && archives["total_production"] != nil && archives["register"] != nil
      total_production = archives["total_production"]
      register = archives["register"]


      database1 = Mdb.open(register.tempfile)
      database2 = Mdb.open(total_production.tempfile)

      if database1 != nil && database2 != nil
        year_months = params[:year_months]
        update_tp = params[:update_tp]
        AgentsController.update_db(database1, database2, year_months, update_tp)
      end

    end

    redirect_to index_path

  end


  end
