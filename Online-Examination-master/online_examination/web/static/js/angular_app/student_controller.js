

function add_new_student($http, $scope){  

    $scope.hide_popup_windows();
    $('#add_student_details')[0].setStyle('display', 'block');        
    $scope.popup = new DialogueModelWindow({

        'dialogue_popup_width': '79%',
        'message_padding': '0px',
        'left': '28%',
        'top': '182px',
        'height': 'auto',
        'content_div': '#add_student_details'
    });
    var height = $(document).height();
    $scope.popup.set_overlay_height(height);
    $scope.popup.show_content();
}

function save_new_student($http, $scope) {
    console.log('hi',validate_new_student($scope))
    if(validate_new_student($scope)) {
        var height = $(document).height();
        height = height + 'px';
        
        $('#overlay').css('height', height);
        $('#spinner').css('height', height);

        $scope.dob = $$('#dob')[0].get('value');
        params = { 
            'student_name':$scope.student_name,
            'registration_no': $scope.registration_no,
            'age': $scope.age,
            'hall_ticket_no': $scope.hall_ticket_no,
            'course': $scope.course,
            // 'semester': $scope.semester,
            'specialization': $scope.specialization,
            'pass_out_year': $scope.pass_out_year,
            'father_name': $scope.father_name,
            'source_of_information':$scope.source_of_information,
            'dob': $scope.dob,
            'address': $scope.address,
            'mobile_number': $scope.mobile_number,
            'email':$scope.email,
            'guardian_name': $scope.guardian_name,
            'permanent_address':$scope.permanent_address,
            'guardian_mobile_number': $scope.guardian_mobile_number,
            "csrfmiddlewaretoken" : $scope.csrf_token
        }
        var fd = new FormData();

        fd.append('photo_img', $scope.photo_img.src)
        
        for(var key in params){
            fd.append(key, params[key]);          
        }
        var url = "/academic/add_student/";
        $http.post(url, fd, {
            transformRequest: angular.identity,
            headers: {'Content-Type': undefined
            }
        }).success(function(data, status){
            if (data.result == 'error'){
                $scope.error_flag=true;
                $scope.validation_error = data.message;
                $('#spinner').css('height', '0px');
            }
            else {
                $scope.auto_genrated_password = data.auto_genrated_password;
                $('#spinner').css('display', 'none');
                $('#dialogue_popup').css('display', 'block');
                $('#show_password').css('display', 'block');
            }

        }).error(function(data, status){
            $scope.error_flag=true;
            $scope.validation_error = data.message;
            $('#spinner').css('height', '0px');
        });
    }
}

function reset_student($scope) {
    $scope.student_name = '';
    $scope.roll_number = '';
    $scope.course = '';
    $scope.batch = '';
    $scope.source_of_information = '';
    $scope.semester = '';
    $scope.qualified_exam = '';
    $scope.technical_qualification = '';
    $scope.dob = '';
    $scope.address = '';
    $scope.mobile_number = '';
    $scope.land_number = '';
    $scope.email = '';
    $scope.blood_group = '';
    $scope.doj = '';
    $scope.certificates_submitted = '';
    $scope.certificates_remarks = '';
    $scope.certificates_file = '';
    $scope.id_proof = '';
    $scope.id_proof_remarks = '';
    $scope.id_proof_file = '';
    $scope.guardian_name = '';
    $scope.guardian_address = '';
    $scope.relationship = '';
    $scope.guardian_mobile_number = '';
    $scope.guardian_land_number = '';
    $scope.guardian_email    = '';
    $scope.photo_img = {};
}
validate_new_student = function($scope) {
    $scope.validation_error = '';
    $scope.dob = $$('#dob')[0].get('value');

    if($scope.student_name == '' || $scope.student_name == undefined) {
        $scope.validation_error = "Please Enter the Name" ;
        return false;
    }   
    else if($scope.course == '' || $scope.course == undefined) {
        $scope.validation_error = "Please Enter Course";
        return false;
    }else if($scope.dob == '' || $scope.dob == undefined) {
        $scope.validation_error = "Please Enter DOB";
        return false;
    } else if($scope.address == '' || $scope.address == undefined) {
        $scope.validation_error = "Please Enter Address";
        return false;
    } else if($scope.mobile_number == ''|| $scope.mobile_number == undefined){
        $scope.validation_error = "Please enter the Mobile Number";
        return false;
    } else if(!(Number($scope.mobile_number)) || $scope.mobile_number.length > 15) {            
        $scope.validation_error = "Please enter a Valid Mobile Number";
        return false;
    } else if(($scope.email != '' && $scope.email != undefined) && (!(validateEmail($scope.email)))){
        $scope.validation_error = "Please enter a Valid Email Id";
        return false;
    }  else if($scope.permanent_address == '' || $scope.permanent_address == undefined) {
        $scope.validation_error = "Please Enter Permanent Address";
        return false;
    } else if($scope.guardian_mobile_number == ''|| $scope.guardian_mobile_number == undefined){
        $scope.validation_error = "Please enter the Mobile Number";
        return false;
    } else if(!(Number($scope.guardian_mobile_number)) || $scope.guardian_mobile_number.length > 15) {            
        $scope.validation_error = "Please enter a Valid Mobile Number";
        return false;
    }
    return true;
}   


function EditStudentController($scope, $http, $element, $location, $timeout) {
    $scope.init = function(csrf_token, student_id){

        $scope.csrf_token = csrf_token;
        $scope.student_id = student_id;
        
        $scope.url = '/academic/edit_student_details/' + $scope.student_id+ '/';
        $http.get($scope.url).success(function(data)
        {
            
            $scope.student = data.student[0];
        }).error(function(data, status)
        {
            console.log(data || "Request failed");
        });
        
        new Picker.Date($$('#dob'), {
            timePicker: false,
            positionOffset: {x: 5, y: 0},
            pickerClass: 'datepicker_bootstrap',
            useFadeInOut: !Browser.ie,
            format:'%d/%m/%Y',
        });
        new Picker.Date($$('#doj'), {
            timePicker: false,
            positionOffset: {x: 5, y: 0},
            pickerClass: 'datepicker_bootstrap',
            useFadeInOut: !Browser.ie,
            format:'%d/%m/%Y',
        });
        get_course_list($scope, $http);
        get_semester_list($scope, $http);
    }
    $scope.get_semester = function(){
        var url = '/college/get_semester/?id='+$scope.course;
        $http.get(url).success(function(data) {
            $scope.semesters = '';
            $scope.semesters = data.semesters;
        }).error(function(data, status)
        {
            console.log(data || "Request failed");
        });
    }
    $scope.validate_edit_student = function() {
        $scope.validation_error = '';
        $scope.dob = $$('#dob')[0].get('value');

        if($scope.student.student_name == '' || $scope.student.student_name == undefined) {
            $scope.validation_error = "Please Enter the Name" ;
            return false;
        }   
        else if($scope.student.course == '' || $scope.student.course == undefined) {
            $scope.validation_error = "Please Enter Course";
            return false;
        }else if($scope.student.dob == '' || $scope.student.dob == undefined) {
            $scope.validation_error = "Please Enter DOB";
            return false;
        } else if($scope.student.address == '' || $scope.student.address == undefined) {
            $scope.validation_error = "Please Enter Address";
            return false;
        } else if($scope.student.mobile_number == ''|| $scope.student.mobile_number == undefined){
            $scope.validation_error = "Please enter the Mobile Number";
            return false;
        } else if(!(Number($scope.student.mobile_number)) || $scope.student.mobile_number.length > 15) {            
            $scope.validation_error = "Please enter a Valid Mobile Number";
            return false;
        } else if(($scope.student.email != '' && $scope.student.email != undefined) && (!(validateEmail($scope.student.email)))){
            $scope.validation_error = "Please enter a Valid Email Id";
            return false;
        }  else if($scope.student.permanent_address == '' || $scope.student.permanent_address == undefined) {
            $scope.validation_error = "Please Enter Permanent Address";
            return false;
        } else if($scope.student.guardian_mobile_number == ''|| $scope.student.guardian_mobile_number == undefined){
            $scope.validation_error = "Please enter the Mobile Number";
            return false;
        } else if(!(Number($scope.student.guardian_mobile_number)) || $scope.student.guardian_mobile_number.length > 15) {            
            $scope.validation_error = "Please enter a Valid Mobile Number";
            return false;
        }
        return true;
        
    }   
    $scope.edit_student = function() {
        if ($scope.validate_edit_student()){
            $scope.error_flag=false;
            $scope.message = '';
           
            params = { 
                'student': angular.toJson($scope.student),
                "csrfmiddlewaretoken" : $scope.csrf_token
            }
            var fd = new FormData();
            console.log($scope.student.photo.src)
            fd.append('photo', $scope.student.photo.src)
            console.log($scope.student.photo.src)
            for(var key in params){
                fd.append(key, params[key]);          
            }
            $http.post($scope.url, fd, {
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined
                }
            }).success(function(data, status) {
                
                if (data.result == 'error'){
                    $scope.error_flag=true;
                    $scope.message = data.message;
                } else {
                    $scope.error_flag=false;
                    $scope.message = '';
                    document.location.href = '/academic/list_student/';
                }
            }).error(function(data, status){
                $scope.error_flag=true;
                $scope.message = data.message;
            });
        }
    }
}


function StudentListController($scope, $http, $element, $location, $timeout) {

    $scope.init = function(csrf_token){
        get_course_list($scope, $http);
        $scope.page_interval = 10;
        $scope.show_password = '';
        $scope.visible_list = [];
        $scope.students = [];
        $scope.csrf_token = csrf_token;
        $scope.error_flag = false;
        $scope.popup = '';      
        $scope.pages = 1;
        var date_pick = new Picker.Date($$('#dob'), {
            timePicker: false,
            positionOffset: {x: 5, y: 0},
            pickerClass: 'datepicker_bootstrap',
            useFadeInOut: !Browser.ie,
            format:'%d/%m/%Y',
        });
        reset_student($scope);
    }
    $scope.get_semester = function(){
        var url = '/college/get_semester/?id='+$scope.course;
        $http.get(url).success(function(data) {
            $scope.semesters = '';
            $scope.semesters = data.semesters;
        }).error(function(data, status)
        {
            console.log(data || "Request failed");
        });
    }
    $scope.get_students = function(){
        console.log("sjsj")
        var url = '/academic/list_student/?course_id='+ $scope.course;
        $http.get(url).success(function(data)
        {
            $scope.students = data.students;
            paginate(data.students, $scope);
        }).error(function(data, status)
        {
            console.log(data || "Request failed");
        });
    }
    $scope.save_new_student = function(){
        save_new_student($http, $scope);
    }   
    $scope.display_student_details = function(student) {
        $scope.student_id = student.id;
        $scope.url = '/academic/view_student_details/' + $scope.student_id+ '/';
        $http.get($scope.url).success(function(data)
        {
            $scope.student = data.student[0];
        }).error(function(data, status)
        {
            console.log(data || "Request failed");
        });

        $('#student_details_view')[0].setStyle('display', 'block');
        
        $scope.popup = new DialogueModelWindow({                
            'dialogue_popup_width': '78%',
            'message_padding': '0px',
            'left': '28%',
            'top': '182px',
            'height': 'auto',
            'content_div': '#student_details_view'
        });
        
        var height = $(document).height();
        $scope.popup.set_overlay_height(height);
        $scope.popup.show_content();
    }
    $scope.close_popup = function(){
        $scope.popup.hide_popup();
    }
     $scope.close_popup_password = function(){
        document.location.href = '/academic/add_student/';
    }
    $scope.select_page = function(page){
        select_page(page, $scope.students, $scope);
    }
    $scope.range = function(n) {
        return new Array(n);
    }
}