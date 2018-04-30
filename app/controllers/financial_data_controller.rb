class FinancialDataController < ApplicationController

    before_action :logged_in_user, only: [:create, :destroy, :new, :index]
    @@financial_data_result = nil
    def index
        @financial_data = current_user.financial_data.paginate(page: params[:page], per_page: 10)
        @temp = nil
    end

    def new
        @financial_datum = FinancialDatum.new
    end

    def show 
        @user = current_user
        if @@financial_data_result
            @financial_data = @@financial_data_result.paginate(page: params[:page], per_page: 6)
        else    
            @financial_data = @user.financial_data.paginate(page: params[:page], per_page: 6)
        end
            @financial_datum = FinancialDatum.new
    end

    def create
        @financial_datum = current_user.financial_data.new(financial_datum_params)
        @financial_datum.description = params[:financial_datum][:kind]
        if @financial_datum.save
            flash[:success] = "Successfully created data >!"
            redirect_to :action => 'index'
        else
            render 'new'
        end
    end

    def edit
        @financial_datum = FinancialDatum.find(params[:id])
    end

    def search
        @financial_data = current_user.financial_data.paginate(page: params[:page], per_page: 6)
        @financial_datum = current_user.financial_data
        time = params[:commit_time]
        time = time.split("-")
        time = Time.mktime(time[0].to_i,time[1].to_i,time[2].to_i) 
        p time
        p time_beg = time.beginning_of_day
        p time_end = time.end_of_day
        @financial_search = FinancialDatum.where("user_id = ? and commit_time > ? and commit_time < ?", 
                                                 current_user.id, time_beg, time_end)
        if @financial_search
            @financial_data = @financial_search.paginate(page: params[:page], per_page: 6)
            @@financial_data_result = @financial_data
            flash[:success] = "Results is in this page"
            render 'show'
        else
            flash.now[:danger] = " Got no Results "
            render 'show'
        end
    end


    def update
        @financial_datum = FinancialDatum.find(params[:id])
        @financial_datum.description = params[:financial_datum][:kind]
        if @financial_datum.update_attributes(financial_datum_params)
          # 处理更新成功的情况
          flash[:success] = "Profile updated"
          redirect_to :action => 'index'
        else
          render 'edit'
        end
    end

    def destroy
        FinancialDatum.find(params[:id]).destroy
        flash[:success] = "User was successfully deleted"
        redirect_to financial_data_url
    end
    
    private
    def financial_datum_params
        params.require(:financial_datum).permit(:details, 
                                                :money,
                                                :kind,
                                                :note, 
                                                :commit_time)
    end
end
