import React, { useState } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import Icon from '@material-ui/core/Icon';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import MenuItem from '@material-ui/core/MenuItem';
import Typography from '@material-ui/core/Typography';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';
import Autocomplete from '@material-ui/lab/Autocomplete';


import { dataSourceLabels, knownOracles } from './common'

const useStyles = makeStyles({
    root: {
        minWidth: 275,
    },
    bullet: {
        display: 'inline-block',
        margin: '0 2px',
        transform: 'scale(0.8)',
    },
    title: {
        fontSize: 14,
    },
    pos: {
        marginBottom: 12,
    },
});

const triggers = {
    'time': {
        'label': 'По времени',
    }
}

const timeOptions = [
    {
        'label': 'Раз в минуту',
        'value': '0 * * * * *'
    },
    {
        'label': 'Раз в час',
        'value': '0 0 * * * *'
    }
]

export default function NewOracleCard(props) {
    const classes = useStyles();
    const {
        confirm,
        testDataSource
    } = props

    const [dataSources, setDateSources] = useState([{
        dataSourceType: 'url',
        dataSourceOracles: knownOracles
    }])

    const [name, setName] = useState()
    const [signatures, setSignatures] = useState(2)
    const [trigger, setTrigger] = useState(timeOptions[0].value)

    const [testResult, setTestResult] = useState()
    const [testDialogOpen, setTestDialogOpen] = useState(false)

    const doTestDataSource = async (ds) => {
        const result = await testDataSource(ds)
        setTestResult(result)
        setTestDialogOpen(true)
    }

    const doConfirm = () => {
        confirm({
            name,
            signatures,
            trigger,
            dataSources
        })
    }

    const doAddDataSource = () => {
        setDateSources([...dataSources, {
            dataSourceType: 'url',
            dataSourceOracles: knownOracles
        }])
    }

    const doDeleteDataSource = (index) => {
        setDateSources([...dataSources.slice(0, index), ...dataSources.slice(index + 1)])
    }

    const setDataSourceAttribute = (index, attr, value) => {
        const replace = {}
        const newDataSource = {
            ...dataSources[index]
        }
        newDataSource[attr] = value
        replace[index] = newDataSource
        const newDataSources = Object.assign([], dataSources, replace);
        setDateSources(newDataSources)
    }

    const validateDs = (ds) => {
        return ds.dataSourceExpression && ds.dataTransformationScript
    }

    const validate = () => {
        return name && dataSources.filter(ds => !validateDs(ds)) == 0
    }

    const maxConfirmationCount = () => {
        return dataSources.map(ds => ds.dataSourceOracles.length).reduce((a, c) => a + c, 0)
    }


    return (
        <Card className={classes.root}>
            <Dialog
                open={testDialogOpen}
                onClose={() => setTestDialogOpen(false)}
                aria-labelledby="alert-dialog-title"
                aria-describedby="alert-dialog-description"
            >
                <DialogTitle id="alert-dialog-title">Тестирование источника данных</DialogTitle>
                <DialogContent>
                    <DialogContentText id="alert-dialog-description">
                        {testResult}
                    </DialogContentText>
                </DialogContent>
                <DialogActions>
                    <Button onClick={() => setTestDialogOpen(false)} color="primary" autoFocus>
                        Закрыть
                     </Button>
                </DialogActions>
            </Dialog>
            <CardContent>
                <form style={{}} noValidate autoComplete="off" style={{ textAlign: 'left' }}>
                    <div>
                        <TextField
                            required
                            value={name}
                            fullWidth
                            label="Наименование оракула"
                            onChange={(e) => setName(e.target.value)} />
                    </div>
                    {
                        dataSources.map((dataSource, index) => <div key={index}>
                            <Typography variant="h6" component="h2" style={{ 'marginTop': 10 }} gutterBottom>
                                Источник данных {index + 1}
                                {
                                    index > 0 ? (<Button onClick={() => doDeleteDataSource(index)}><Icon>delete</Icon></Button>) : ''
                                }
                            </Typography>
                            <div>
                                <TextField
                                    required
                                    fullWidth
                                    select
                                    label="Тип источника данных"
                                    value={dataSource.dataSourceType}
                                    onChange={(e) => setDataSourceAttribute(index, 'dataSourceType', e.target.value)}
                                    helperText="Выберите тип источника данных"
                                >
                                    {Object.keys(dataSourceLabels).map((key) => (
                                        <MenuItem key={key} value={key}>
                                            {dataSourceLabels[key].dataSourceType}
                                        </MenuItem>
                                    ))}
                                </TextField>
                                <Autocomplete
                                    required
                                    fullWidth
                                    multiple
                                    label="Исполнитель"
                                    options={knownOracles}
                                    getOptionLabel={(knownOracle) => knownOracle.address}
                                    value={dataSource.dataSourceOracles}
                                    onChange={(_, values) => setDataSourceAttribute(index, 'dataSourceOracles', values)}
                                    renderInput={(params) => (
                                        <TextField
                                          {...params}
                                          variant="standard"
                                          label="Исполнители"
                                          placeholder="Добавить исполнителя"
                                        />
                                      )}                                    
                                />
                                <TextField
                                    fullWidth
                                    required
                                    label={dataSourceLabels[dataSource.dataSourceType].dataSourceExpression}
                                    value={dataSource.dataSourceExpression}
                                    onChange={(e) => setDataSourceAttribute(index, 'dataSourceExpression', e.target.value)}
                                />
                                <TextField
                                    fullWidth
                                    required
                                    label={dataSourceLabels[dataSource.dataSourceType].dataTransformationScript}
                                    value={dataSource.dataTransformationScript}
                                    onChange={(e) => setDataSourceAttribute(index, 'dataTransformationScript', e.target.value)}
                                />
                                <div>
                                    <Button
                                        disabled={!validateDs(dataSources[index])}
                                        style={{ 'marginTop': 5 }}
                                        variant="outlined"
                                        color="default"
                                        size="small"
                                        onClick={() => doTestDataSource(dataSources[index])}>
                                            Протестировать
                                    </Button>
                                </div>
                            </div>
                        </div>)
                    }
                    <div style={{ marginTop: 5 }}>
                        <Button
                            variant="outlined"
                            color="primary"
                            size="small"
                            onClick={doAddDataSource}>Добавить источник</Button>
                    </div>
                    <Typography variant="h6" component="h2" style={{ 'marginTop': 10 }} gutterBottom>
                        Консенсус
                    </Typography>
                    <div>
                        <TextField
                            fullWidth
                            required
                            select
                            label="Количество подтверждений"
                            value={signatures}
                            onChange={(e) => setSignatures(e.target.value)}
                            helperText="Количество подтверждений (подписей) от оракулов"
                        >
                            {new Array(maxConfirmationCount()).fill(1).map( (_, i) => i + 1).map((key) => (
                                <MenuItem key={key} value={key}>
                                    {key}
                                </MenuItem>
                            ))}
                        </TextField>
                    </div>
                    <Typography variant="h6" component="h2" style={{ 'marginTop': 10 }} gutterBottom>
                        Тип события
                    </Typography>
                    <TextField
                        fullWidth
                        required
                        select
                        label="Тип события"
                        value={'time'}
                        helperText="Выберите тип события по которому будет срабатывать оракул"
                    >
                        {Object.keys(triggers).map((key) => (
                            <MenuItem key={key} value={key}>
                                {triggers[key].label}
                            </MenuItem>
                        ))}
                    </TextField>
                    <TextField
                        fullWidth
                        required
                        select
                        label="Частота"
                        value={trigger}
                        onChange={(e) => setTrigger(e.target.value)}
                        helperText="Выберите частоту срабатывания"
                    >
                        {timeOptions.map((option) => (
                            <MenuItem key={option.value} value={option.value}>
                                {option.label}
                            </MenuItem>
                        ))}
                    </TextField>
                </form>
            </CardContent>

            <CardActions>
                <Button
                    disabled={!validate()}
                    variant="outlined"
                    color="primary"
                    size="small"
                    onClick={doConfirm}>Подтвердить</Button>
            </CardActions>
        </Card>
    );
}