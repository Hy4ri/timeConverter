document.addEventListener('DOMContentLoaded', function () {
    // Set default current time in 24-hour format
    const now = new Date();
    document.getElementById('startHours').value = now.getHours();
    document.getElementById('startMinutes').value = now.getMinutes();

    document.getElementById('addTimeForm').addEventListener('submit', function (e) {
        e.preventDefault(); // Prevent page reload

        const startHours = parseInt(document.getElementById('startHours').value, 10) || 0;
        const startMinutes = parseInt(document.getElementById('startMinutes').value, 10) || 0;
        const addHours = parseInt(document.getElementById('addHours').value, 10) || 0;
        const addMinutes = parseInt(document.getElementById('addMinutes').value, 10) || 0;

        const totalStartMinutes = startHours * 60 + startMinutes;
        const totalAddMinutes = addHours * 60 + addMinutes;
        const resultMinutes = totalStartMinutes + totalAddMinutes;

        const resultHours = Math.floor(resultMinutes / 60) % 24;
        const resultRemainingMinutes = resultMinutes % 60;
        const period = resultHours >= 12 ? 'PM' : 'AM';

        const displayHours = resultHours > 12 ? resultHours - 12 : resultHours || 12;

        const resultText = `${displayHours}:${resultRemainingMinutes.toString().padStart(2, '0')} ${period}`;
        document.getElementById('result').innerText = resultText;
    });
});
