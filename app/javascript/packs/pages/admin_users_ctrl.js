(function () {
    app.controller('AdminUsersCtrl', [
        "$scope", '$timeout', function ($scope, $timeout) {
            $scope.page = 1;
            $scope.page_size = '50';
            $scope.data = [];
            $scope.search = "";
            $scope.user_ids = "";
            $scope.is_check_all = false;
            
            $scope.init = function() {

            }

            $scope.getData = function() {
                $scope.page = 1;
                $scope.executeUsers();
            }

            $scope.executeUsers = function() {
                var params = {
                    page: $scope.page,
                    page_size: $scope.page_size,
                    search: $scope.search
                }
                $scope.is_check_all = false;
                $scope.user_ids = "";
                $.get($scope.execute_users_admin_users_path, params, function (rs) {
                    $timeout(function() {
                        if (rs && rs.succeed) {
                            $scope.data = rs.data;
                            $scope.total_pages = Math.ceil(rs.total / $scope.page_size)
                        } else {
                            $scope.data = [];
                        }
                    })
                });
            }

            $scope.previous = function() {
                if($scope.page == 1) return;
                $scope.page--;
                $scope.executeUsers();
            }

            $scope.next = function() {
                if($scope.page == $scope.total_pages) return;
                $scope.page++;
                $scope.executeUsers();
            }

            $scope.change_page = function(page) {
                if($scope.page == page) return;
                $scope.page = page;
                $scope.executeUsers();
            }

            $scope.check_user = function() {
                let user_check = $scope.data.filter((u) => u.check);
                $scope.user_ids = user_check.map(u => u.id).join(',');
                if ($scope.is_check_all) {
                    $scope.is_check_all = $scope.data.every(h => !h.check)
                }
            }

            $scope.check_all = function() {
                $scope.data.forEach(d => {
                    d.check = $scope.is_check_all;
                });
                if ($scope.is_check_all)  $scope.user_ids = "";
            }

            $scope.delete_student = function() {
                if (confirm('Are you sure?')) {
                    if (!$scope.is_check_all && !$scope.user_ids) return;
    
                    var opt = {
                        user_ids: $scope.user_ids,
                        search: $scope.search
                    }
    
                    $.post($scope.delete_student_path, opt, function(rs) {
                        $timeout(function() {
                            if (rs && rs.succeed) {
                                toastr.success('Successed');
                                $scope.search = "";
                                $scope.getData();
                            } else {
                                toastr.error(rs.message);
                            }
                        })
                    })
               }
            }
        }
	]);
}).call(this);