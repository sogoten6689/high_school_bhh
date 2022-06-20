$(document).ready(function() {
    $('#full_name').on('input', function () {
        $full_name_string = this.value;
        $array_full_name = $full_name_string.split(' ');
        $last_name = $array_full_name.slice(-1)[0];
        $('#name').val($last_name);
        // $('#name').val($last_name.toUpperCase());
        // $('#full_name').val($full_name_string.toUpperCase());
    });

    $('#ethnicity').on('change', function () {
        if (this.value == 0) {
            $('#another_ethnicity').attr('readonly', false);
        } else {
            $('#another_ethnicity').val('');
            $('#another_ethnicity').attr('readonly', true);
        }
    });

    $('#none_identification').change( function () {
        if (this.checked){
            $('#identification').val('');
            $('#identification').attr('readonly', true);
        } else {
            $('#identification').attr('readonly', false);
        }
    });
});

// $(document.body).on("change","#ethnicity",function(){
//     alert(this.value);
// });

