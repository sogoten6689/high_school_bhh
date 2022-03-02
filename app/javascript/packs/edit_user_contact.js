$('#household_province').on('change', function () {
    $('#household_district').empty();
    $.ajax({
        url : '/provinces/'+this.value+'/districts',
        type : 'GET',
        dataType:'json',
        success : function(data) {
            $.each(data, function(key, value) {
                $('#household_district').append(`<option value="${value.code}">${value.name}</option>`);
            });
            $('#household_district').change();
        },
        error : function(request,error)
        {
            console.log(request);
            console.log(error);
        }
    });
});

$('#household_district').on('change', function () {
    $('#household_ward').empty();
    $.ajax({
        url : '/districts/'+this.value+'/wards',
        type : 'GET',
        dataType:'json',
        success : function(data) {
            $.each(data, function(key, value) {
                $('#household_ward').append(`<option value="${value.code}">${value.name}</option>`);
            });
        },
        error : function(request,error)
        {
            console.log(request);
            console.log(error);
        }
    });
});

$('#contact_province').on('change', function () {
    $('#contact_district').empty();
    $.ajax({
        url : '/provinces/'+this.value+'/districts',
        type : 'GET',
        dataType:'json',
        success : function(data) {
            $.each(data, function(key, value) {
                $('#contact_district').append(`<option value="${value.code}">${value.name}</option>`);
            });
            $('#contact_district').change();
        },
        error : function(request,error)
        {
            console.log(request);
            console.log(error);
        }
    });
});

$('#contact_district').on('change', function () {
    $('#contact_ward').empty();
    $.ajax({
        url : '/districts/'+this.value+'/wards',
        type : 'GET',
        dataType:'json',
        success : function(data) {
            $.each(data, function(key, value) {
                $('#contact_ward').append(`<option value="${value.code}">${value.name}</option>`);
            });
        },
        error : function(request,error)
        {
            console.log(request);
            console.log(error);
        }
    });
});
