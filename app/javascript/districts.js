document.addEventListener("turbo:load", () => {
    const divisionSelect = document.getElementById("division-select");
    const districtSelect = document.getElementById("district-select");

    if (divisionSelect && districtSelect) {
        divisionSelect.addEventListener("change", function() {
            const divisionId = this.value;

            // Clear the district select and show a loading message
            districtSelect.innerHTML = '<option value="">Loading...</option>';

            // Fetch districts for the selected division
            fetch(`/districts/${divisionId}`, {
                headers: { 'Accept': 'application/json' }
            })
                .then(response => response.json())
                .then(data => {
                    // Clear the district select options and add the new ones
                    districtSelect.innerHTML = '';
                    districtSelect.insertAdjacentHTML('beforeend', '<option value="">Select a District</option>');

                    data.forEach(district => {
                        const option = document.createElement('option');
                        option.value = district.id;
                        option.textContent = district.name;
                        districtSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Error fetching districts:', error);
                    districtSelect.innerHTML = '<option value="">Error loading districts</option>';
                });
        });
    }
});
