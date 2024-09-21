$(document).on('change', '#division-select', function() {
    const divisionId = $(this).val();

    $.ajax({
        url: '/districts', // Adjust to your route for fetching districts
        method: 'GET',
        data: { division_id: divisionId, page: 1 },
        dataType: 'json',
        success: function(data) {
            const $districtSelect = $('#district-select');
            $districtSelect.empty(); // Clear existing options
            $districtSelect.append($('<option>').text('Select a District').attr('value', '')); // Add prompt

            $.each(data, function(index, district) {
                $districtSelect.append($('<option>').text(district.name).attr('value', district.id));
            });
        }
    });
});
