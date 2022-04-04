(function () {
    app.controller('AdminUsersCtrl', [
        "$scope", '$timeout', function ($scope, $timeout) {
            $scope.page = 1;
            $scope.page_size = '10';
            
            $scope.init = function() {

            }

            $scope.getData = function() {
                $scope.page = 1;
                $scope.executeUsers();
            }

            $scope.executeUsers = function() {
                var params = {
                    page: $scope.page,
                    page_size: $scope.page_size
                }
                $.get($scope.execute_users_admin_users_path, params, function (rs) {
                    $timeout(function() {
                        if (rs && rs.succeed) {
                            $scope.data = rs.data;
                            $scope.total_pages = Math.ceil(rs.total / $scope.page_size)
                            console.log(rs.data);
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

            $scope.range = function(n) {
                return new Array(n);
            };
        }
	]);
}).call(this);