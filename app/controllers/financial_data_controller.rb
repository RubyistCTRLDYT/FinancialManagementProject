class FinancialDataController < ApplicationController

    before_action :logged_in_user, only: [:create, :destroy, :new, :index]

    def index
        @financial_data = current_user.financial_data.paginate(page: params[:page], per_page: 10)
        @temp = nil
    end

    def new
        @financial_datum = FinancialDatum.new
    end

    def show 
        @financial_data = current_user.financial_data
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
