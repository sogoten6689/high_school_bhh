class StatisticsController < ApplicationController
    def index
        return redirect_to home_path if current_user.role < 2 

        @breadcrumbs = [
            ['Thống kê', statistics_path],
          ]
        @current_tab = params[:tab] || 'elective_subjects'
        search = AppUtils.escape_search_query(params[:search])
        search = AppUtils.quote_string(search)

        # elective_subjects tab
        if @current_tab == 'elective_subjects'
            # Todo
        end

        # elective_subjects tab
        if @current_tab == 'elective_subjects'
            # Todo
        end
    end
end
