export const knownOracles = [
    {
        "address": "3QVUnXdCq7vMJDjfcuM7G5qCqFKeBQuac8P",
        "publicKey": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAECSjyPMNqA5E8XnztmvdDhUboKQaq9wgUv8rWAgfFYR9Sh9UF5/ss4ClgJUCG1mKH8aTO/qZVnYyY8J2BOO4pAA=="
    },
    {
        "address": "3Qbur18V2vQfJEcnkqM3H9ieNozVup4mG2v",
        "publicKey": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEeJEbcJ7fMx9UZZeVRYeF8YOZB3ZOLK2SooCj28SVcasX7QwImeqlk7Sc+n8k2PCXDDiqll2L0aQ7MBQ3ux3k+A=="
    },
    {
        "address": "3QZdm3KxwX4GRdrdGLxeZ4xmEyrv5rEXCqF",
        "publicKey": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAETqsbijXCcXeX67luiVT00HbGtNpiv0OUV8xtDCOdvFtIN2/7Yo7y2B3Qhl1f0OhNi8VdlUjcM165BhzLMVPBrg=="
    }
]

export const dataSourceLabels = {
    'html': {
        'dataSourceExpression': 'Адрес страницы',
        'dataTransformationScript': 'Элемент страницы',
        'dataSourceType': 'HTML Страница'
    },
    'url': {
        'dataSourceExpression': 'Адрес API',
        'dataTransformationScript': 'Элемент API (JsonPath)',
        'dataSourceType': 'REST API (Json)'
    },
    'xml': {
        'dataSourceExpression': 'Адрес API',
        'dataTransformationScript': 'Элемент API (XPath)',
        'dataSourceType': 'XML API'
    },
}