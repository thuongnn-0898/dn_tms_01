class ReportsController < ApplicationController
    before_action :check_report_today, only: :create
    def new
        @report = Report.new
    end

    def create
        @report = current_user.reports.build report_params
        if @report.save
            flash[:success] = t "messages.save_success"
            redirect_to request.referer
        else
            render :new
        end
    end

    private

    def report_params
        params.require(:report).permit :title, :content
    end

    def check_report_today
        return unless Report.check_report_today
        flash[:success] = "Bạn đã viết báo cáo cho hôm này rồi"
        redirect_to request.referer
    end
end
