function EditSemesterController($scope, $http, $element, $location, $timeout) {
    $scope.init = function(csrf_token, semester_id){
        $scope.csrf_token = csrf_token;
        $scope.semester_id = semester_id;
        $scope.url = '/college/edit_semester/' + $scope.semester_id+ '/';
        $http.get($scope.url).success(function(data)
        {
            $scope.semester = data.semester[0];
        }).error(function(data, status)
        {
            console.log(data || "Request failed");
        });
        
    }
    $scope.validate_edit_semester = function() {

        
        $scope.validation_error = '';

        if($scope.semester.semester == '' || $scope.semester.semester == undefined) {
            $scope.validation_error = "Please Enter semester Name" ;
            return false;
        } return true;   
     }

    $scope.save_semester = function() {
        $scope.is_valid = $scope.validate_edit_semester();
        if ($scope.is_valid) {
            $scope.error_flag=false;
            $scope.message = '';
           
            params = { 
                'semester': angular.toJson($scope.semester),
                "csrfmiddlewaretoken" : $scope.csrf_token
            }
            $http({
                method : 'post',
                url : $scope.url,
                data : $.param(params),
                headers : {
                    'Content-Type' : 'application/x-www-form-urlencoded'
                }
            }).success(function(data, status) {
                
                if (data.result == 'error'){
                    $scope.error_flag=true;
                    $scope.message = data.message;
                } else {
                    $scope.error_flag=false;
                    $scope.message = '';
                    document.location.href = '/college/list_semester/';
                }
            }).error(function(data, status){
                $scope.error_flag=true;
                $scope.message = data.message;
            });
        }
    }
}


function EditCourseController($scope, $http, $element, $location, $timeout) {
    $scope.init = function(csrf_token, course_id){
        $scope.csrf_token = csrf_token;
        $scope.course_id = course_id;
        $scope.get_semester();
        $scope.semester_list = [];
        $scope.url = '/college/edit_course/' + $scope.course_id+ '/';
        $http.get($scope.url).success(function(data)
        {   
            $scope.course = data.course[0];
            for(var i = 0; i < $scope.course.semester_details.length; i++){
                for(var j = 0; j < $scope.semesters.length; j++){
                    if($scope.semesters[j].id == $scope.course.semester_details[i].semester_id){
                        $scope.semesters[j].selected = true;
                        $scope.semester_list.push($scope.semesters[j].id);
                    }           
                }
            }
        }).error(function(data, status)
        {
            console.log(data || "Request failed");
        });
        
    }
    $scope.get_semester = function(){
        var url = '/college/list_semester/';
        $http.get(url).success(function(data) {
            $scope.semesters = data.semesters;            
        }).error(function(data, status)
        {
            console.log(data || "Request failed");
        });
    }
    $scope.validate_edit_course = function() {

        
        $scope.validation_error = '';     
        if($scope.course.course == '' || $scope.course.course == undefined) {
            $scope.validation_error = "Please Enter course Name" ;
            return false;
        } else if($scope.semester_list == '') {
            $scope.validation_error = "Please Choose Semesters" ;
            return false;
        } 
        return true;   
     }

    $scope.save_course = function() {
        $scope.is_valid = $scope.validate_edit_course();

        if ($scope.is_valid) {
            $scope.error_flag=false;
            $scope.message = '';
            for(var i = 0; i < $scope.course.semester_details.length; i++){
                for(var j = 0; j < $scope.semesters.length; j++){
                    if($scope.semesters[j].id == $scope.course.semester_details[i].semester_id){
                        if($scope.semesters[j].selected = true)
                            $scope.semesters[j].selected = "true"
                    }           
                }
            }

            params = { 
                'course': angular.toJson($scope.course),
                'semester_list': angular.toJson($scope.semester_list),
                "csrfmiddlewaretoken" : $scope.csrf_token
            }
            $http({
                method : 'post',
                url : $scope.url,
                data : $.param(params),
                headers : {
                    'Content-Type' : 'application/x-www-form-urlencoded'
                }
            }).success(function(data, status) {
                
                if (data.result == 'error'){
                    $scope.error_flag=true;
                    $scope.message = data.message;
                } else {
                    $scope.error_flag=false;
                    $scope.message = '';
                    document.location.href = '/college/list_course/';
                }
            }).error(function(data, status){
                $scope.error_flag=true;
                $scope.message = data.message;
            });
        }
  
    }
}



function CollegeController($scope, $element, $http, $timeout, share, $location)
{
    
    $scope.init = function(csrf_token)
    {
        $scope.popup = '';
        $scope.error_flag = false;
        $scope.csrf_token = csrf_token;
        get_course_list($scope, $http);
        // get_branch_list($scope, $http);
    }

    
    validate_new_course = function($scope) {
        $scope.validation_error = '';      
        if($scope.course == '' || $scope.course == undefined) {
            $scope.validation_error = "Please Enter a Course" ;
            return false;
        } else if($scope.semesters == '' || $scope.semesters == undefined){
            $scope.validation_error = "You have to add semesters for creating new course" ;
            return false;
        } else if($scope.semester_list == '' || $scope.semester_list == undefined){
            $scope.validation_error = "Please Choose a semester" ;
            return false;
        } else {
            return true;
        } 
    }
    validate_new_semester = function($scope) {

        
        $scope.validation_error = '';

        if($scope.semester_name== '' || $scope.semester_name == undefined) {
            $scope.validation_error = "Please Enter Semester" ;
            return false;
        }   
        else {
            return true;
        } 
    }
   
    $scope.add_new_course = function(){  
        $scope.popup = new DialogueModelWindow({
            'dialogue_popup_width': '38%',
            'message_padding': '0px',
            'left': '28%',
            'top': '182px',
            'height': 'auto',
            'content_div': '#add_course'
        });
        var height = $(document).height();
        $scope.popup.set_overlay_height(height);
        $scope.popup.show_content();
        get_semester_list($scope, $http);
    }
    $scope.close_popup = function(){
        $scope.popup.hide_popup();
    }
    $scope.save_new_course = function() {
        if(validate_new_course($scope)) {
            params = { 
                'course':$scope.course,
                'semester_list': angular.toJson($scope.semester_list),
                "csrfmiddlewaretoken" : $scope.csrf_token
            }
            $http({
                method: 'post',
                url: "/college/add_new_course/",
                data: $.param(params),
                headers: {
                    'Content-Type' : 'application/x-www-form-urlencoded'
                }
            }).success(function(data, status) {
                if (data.result == 'error'){
                    $scope.error_flag=true;
                    $scope.message = data.message;
                } else {
                    $scope.popup.hide_popup();
                    document.location.href ='/college/list_course/';
                }
            }).error(function(data, success){
                $scope.error_flag=true;
                $scope.message = data.message;
            });
        }
    } 

    $scope.add_new_semseter = function(){  
        $scope.popup = new DialogueModelWindow({
            'dialogue_popup_width': '38%',
            'message_padding': '0px',
            'left': '28%',
            'top': '182px',
            'height': 'auto',
            'content_div': '#add_semester'
        });
        var height = $(document).height();
        $scope.popup.set_overlay_height(height);
        $scope.popup.show_content();
    }
    $scope.close_popup = function(){
        $scope.popup.hide_popup();
    }
    $scope.save_new_semester = function() {
        if(validate_new_semester($scope)) {
            params = { 
                'name': $scope.semester_name,
                "csrfmiddlewaretoken" : $scope.csrf_token
            }
            $http({
                method: 'post',
                url: "/college/add_new_semester/",
                data: $.param(params),
                headers: {
                    'Content-Type' : 'application/x-www-form-urlencoded'
                }
            }).success(function(data, status) {
                
                if (data.result == 'error'){
                    $scope.error_flag=true;
                    $scope.message = data.message;
                } else {
                    $scope.popup.hide_popup();
                    document.location.href ='/college/list_semester/';
                }
            }).error(function(data, success){
                $scope.error_flag=true;
                $scope.message = data.message;
            });
        }
    } 


    $scope.close_popup = function(){
        $scope.popup.hide_popup();
    }
}



