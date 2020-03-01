const { readFileSync, writeFileSync, readdirSync }   = require('fs');
const { safeLoad } = require('js-yaml');
const slugify = require('slugify');
const { cp, mkdirP, rmRF } = require('@actions/io');

const FOLDER = 'public';
const PAGES_FOLDER = 'community';

const ymlPath = `${FOLDER}/data.yml`;
const jsonPath = `${FOLDER}/data.json`;
const sidebarPath = `${FOLDER}/_sidebar.md`;

const sortBy = (key) => {
    return (a, b) => (a[key] > b[key]) ? 1 : ((b[key] > a[key]) ? -1 : 0);
};
const upperFirst = (string) => {
    return string ? string.charAt(0).toUpperCase() + string.slice(1) : ''
};
const getSlugName = (name)=> slugify(name, {
    replacement: '-',
    remove: null,
    lower: true,
});
const createFolders = async ()=> {
    try {
        await rmRF(FOLDER);
        await mkdirP(`${FOLDER}/${PAGES_FOLDER}`);
        await Promise.all(readdirSync('docs')
            .map((file)=>
                cp(`docs/${file}`,FOLDER, { recursive: false, force: true } )))
    } catch (e) {
        console.debug('folder is already exists');
    }
};
const getData = ()=> {
    const json = safeLoad(readFileSync(ymlPath, 'utf8'));
    json.communities = json.communities.sort(sortBy('name'));
    writeFileSync(jsonPath, JSON.stringify(json, null, 2));
    return json;
};
const getDetailPage = ({name, description, links})=> {
    const socialLinks = Object.entries(links)
        .map(([key, value]) => `[${upperFirst(key)}](${value})`)
        .join('\n\n');
    return `# ${name}\n\n${description}\n\n### Linkler\n${socialLinks}`;
};
const generateFilesAndSidebar = ({communities})=> {
    const sidebar = communities.map((community) => {
        const { name }=community;
        const slugName = getSlugName(name);
        const fileName = `${PAGES_FOLDER}/${slugName}.md`;
        writeFileSync(`${FOLDER}/${fileName}`, getDetailPage(community));
        return `* [${name}](/${fileName})`;
    }).join('\n');
    writeFileSync(sidebarPath, sidebar);
};
createFolders()
    .then(()=> {
        try {
            generateFilesAndSidebar(getData());
            console.info('done');
        } catch (e) {
            console.error(e);
        }
});

