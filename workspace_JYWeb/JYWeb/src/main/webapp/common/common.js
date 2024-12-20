document.querySelectorAll('.notiMenu, .normalMenu, .qnaMenu, .shoppingMenu').forEach(menu => {
    menu.addEventListener('mouseover', () => {
        const dropdown = menu.querySelector('.dropdownMenu');
        if (dropdown) dropdown.style.display = 'block';
    });

    menu.addEventListener('mouseout', () => {
        const dropdown = menu.querySelector('.dropdownMenu');
        if (dropdown) dropdown.style.display = 'none';
    });
});
