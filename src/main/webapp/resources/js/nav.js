/**
 * nav.js
 */


document.addEventListener('DOMContentLoaded', function() {
        const tableCells = document.querySelectorAll('.table td');

        tableCells.forEach(cell => {
            cell.addEventListener('click', function() {
                const link = this.querySelector('a');
                if (link) {
                    window.location.href = link.href;
                }
            });
        });
    });