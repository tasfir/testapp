document.addEventListener("turbo:load", () => {
    const districtSelect = document.getElementById("district-select");
    const thanaSelect = document.getElementById("thana-select");

    if (districtSelect && thanaSelect) {
        districtSelect.addEventListener("change", function() {
            const districtId = this.value;

            // Clear the thana select and show a loading message
            thanaSelect.innerHTML = '<option value="">Loading...</option>';

            // Fetch thanas for the selected district
            fetch(`/thanas/${districtId}`, {
                headers: { 'Accept': 'application/json' }
            })
                .then(response => response.json())
                .then(data => {
                    // Clear the thana select options and add the new ones
                    thanaSelect.innerHTML = '';
                    thanaSelect.insertAdjacentHTML('beforeend', '<option value="">Select a Thana</option>');

                    data.forEach(thana => {
                        const option = document.createElement('option');
                        option.value = thana.id;
                        option.textContent = thana.name;
                        thanaSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Error fetching thanas:', error);
                    thanaSelect.innerHTML = '<option value="">Error loading thanas</option>';
                });
        });
    }
});
