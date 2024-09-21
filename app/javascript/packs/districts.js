// app/javascript/packs/districts.js
document.addEventListener("turbo:load", () => {
    const divisionSelect = document.getElementById("division-select");
    const districtSelect = document.getElementById("district-select");

    if (divisionSelect) {
        divisionSelect.addEventListener("change", function() {
            const divisionId = this.value;

            fetch(`/divisions/${divisionId}/districts`, {
                headers: { 'Accept': 'application/json' }
            })
                .then(response => response.json())
                .then(data => {
                    districtSelect.innerHTML = '';
                    districtSelect.insertAdjacentHTML('beforeend', '<option value="">Select a District</option>');

                    data.forEach(district => {
                        const option = document.createElement('option');
                        option.value = district.id;
                        option.textContent = district.name; // Ensure that 'name' is what you want displayed
                        districtSelect.appendChild(option);
                    });
                });
        });
    }
});
