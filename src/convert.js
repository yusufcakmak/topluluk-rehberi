const { readdirSync, readFileSync, writeFileSync } = require('fs');
const { resolve } = require('path');
const { safeDump } = require('js-yaml');

const sortBy = (key) => {
    return (a, b) => (a[key] > b[key]) ? 1 : ((b[key] > a[key]) ? -1 : 0);
};
const getFiles= (dir, carry)=> {
    const dirents = readdirSync(dir, { withFileTypes: true });
    for (const dirent of dirents) {
        const res = resolve(dir, dirent.name);
        if (dirent.isDirectory()) {
            getFiles(res, carry);
        }
        carry.push(res)
    }
    return carry;
};

const files = getFiles('community-pages', []).filter(file => file.endsWith('.md'));
const getName = (lines)=> {
    const hash = '#';
    const [title] = lines.filter(line => line.startsWith(hash));
    return title.split(hash).join('').trim();
};
const getLinks = (lines)=> {
    const hash = '[';
    return lines
        .filter(line => line.startsWith(hash))
        .reduce((result, line)=> {
        const [key, link] = line.slice(1, line.length -1).split('](');
        result[key.toLowerCase()]= link;
        return result;
    }, {})
};
const getDescription = (lines)=> {
    return lines.filter(line => !(line.startsWith('#') || line.startsWith('['))).join(' ');
};
const communities = files.map((file)=> {
    const lines = readFileSync(file).toString().split('\n').filter(Boolean);
    const name = getName(lines);
    const links = getLinks(lines);
    const description = getDescription(lines);
    return {
        name,
        description,
        links
    }
});

const data = {
    communities: communities.sort(sortBy('name'))
};

writeFileSync('docs/data.yml', safeDump(data, {
    sortKeys: true
}));

