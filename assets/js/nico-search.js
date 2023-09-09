import van from '../vendor/van.js'
const { div, button, li } = van.tags;

function CondRow(cond) {
    const handleSearch = () => search(cond);

    const handleDelete = async (e) => {
        if (!window.confirm('削除していいですか？')) return;

        await deleteCondition(cond.id);
        e.target.closest('.search-cond').remove()
    }

    return li(
        {class: "search-cond mt-3"},
        [
            button({ class: "mr-4 border-2 rounded-md px-2", onclick: handleSearch }, 'search'),
            ['word', 'limit', 'minimum_views']
                .map(key => [key, cond[key]])
                .filter(([_, v]) => v !== null)
                .map(([k, v]) => `${k}: ${v}`)
                .join(', '),
            button({ class: 'ml-2 border-2 rounded-md px-2', onclick: handleDelete}, 'delete')
        ]
    );
}

function CondRows(conditions) {
    return conditions.map(cond => CondRow(cond))
}

export function setupNicoSearch() {
    const { conditions: conditionsJson } = document.querySelector('#nico-search-script-data').dataset;
    const conditionsFrame = document.querySelector('#search-conditions');

    const conditions = JSON.parse(conditionsJson || '');
    van.add(conditionsFrame, div(CondRows(conditions)));

    document.querySelector('#save-btn')?.addEventListener('click', async (e) => {
        const form = document.querySelector('#search_nico');
        const word = form.querySelector('input[name="word"]')?.value;
        if (!(word?.length > 0)) return;

        const limit = form.querySelector('[name="limit"]').value;
        const minimumViews = form.querySelector('[name="minimum_views"]').value;

        const res = await saveCondition({
            word,
            limit,
            minimumViews,
        })
        van.add(conditionsFrame, CondRow(res.condition))
    });
}

async function saveCondition({ word, limit, minimumViews }) {
    const url = '/nico/search/cond';
    const formData = new FormData();
    formData.append('word', word);
    formData.append('limit', limit);
    formData.append('minimum_views', minimumViews);
    formData.append('_csrf_token', document.querySelector('meta[name="csrf-token"]').content);
    return fetch(url, {
        method: 'post',
        body: formData,
    }).then(response => response.json())
}

async function deleteCondition(condId) {
    const url = '/nico/search/cond/delete';
    const formData = new FormData();
    formData.append('id', condId);
    formData.append('_csrf_token', document.querySelector('meta[name="csrf-token"]').content);
    return fetch(url, {
        method: 'post',
        body: formData,
    })
}

function search(cond) {
    const url = new URL(location.href)
    Object.entries(cond).forEach(([key, value]) => url.searchParams.append(key, value || ''));
    location.href = url.toString();
}
