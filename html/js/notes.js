let myNotes = [];

function createNewNote() {
    const noteText = prompt("Enter your note:");
    if (noteText) {
        const id = Date.now();
        myNotes.push({ id: id, content: noteText });
        
        $.post(`https://${GetParentResourceName()}/saveNote`, JSON.stringify({
            id: id,
            content: noteText
        }));
        renderNotes();
    }
}

function renderNotes() {
    $('#notes-list').empty();
    myNotes.forEach(note => {
        $('#notes-list').append(`
            <div class="note-item" style="border-bottom: 1px solid #eee; padding: 15px;">
                <p style="color: #333; margin:0;">${note.content}</p>
                <small style="color: #888;">${new Date(note.id).toLocaleDateString()}</small>
            </div>
        `);
    });
}
