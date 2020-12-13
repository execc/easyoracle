import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import Chip from '@material-ui/core/Chip';
import Typography from '@material-ui/core/Typography';

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

export default function OracleCard(props) {
    const classes = useStyles();
    const {
       oracle,
       deleteOracle
    } = props
    return (
        <Card className={classes.root}>
            <CardContent>
                <Typography variant="h5" component="h2" gutterBottom>
                    {oracle.contractName}
                </Typography>
                <Typography variant="overline">
                    {oracle.contractId}
                </Typography>
                {
                    oracle.dataSources.map((source, index) => <div key={index}>
                    <Typography variant="h6" component="h2" gutterBottom>
                        Источник данных {index + 1}
                    </Typography>
                    <Typography className={classes.pos}>
                        <strong>Исполнители:</strong> {
                            source.selector.map(oracle => <Chip style={{marginLeft: 5}} size="small" label={knownOracles.find(it => it.publicKey == oracle).address} />)
                        }
                    </Typography>
                    <Typography className={classes.pos}>
                        <strong>Тип источника данных из внешнего контура:</strong> {dataSourceLabels[source.dataSourceType].dataSourceType}
                    </Typography>
                    <Typography className={classes.pos}>
                        <strong>{dataSourceLabels[source.dataSourceType].dataSourceExpression}:</strong> {source.dataSourceExpression}
                    </Typography>
                    <Typography className={classes.pos}>
                        <strong>{dataSourceLabels[source.dataSourceType].dataTransformationScript}:</strong> {source.dataTransformationScript}
                    </Typography>
                </div>)
                }
                <hr/>
                <Typography className={classes.pos}>
                    <strong>Тип события:</strong> По времени
                </Typography>
                <Typography className={classes.pos}>
                    <strong>Частота срабатывания:</strong> Раз в минуту
                </Typography>
                <hr/>
                <Typography className={classes.pos}>
                    <strong>Требуемое количество подписей:</strong> {oracle.signatures} / 3
                </Typography>
            </CardContent>
            <CardActions>
                <Button variant="outlined" color="primary" size="small" onClick={() => deleteOracle(oracle.id)}>Удалить</Button>
            </CardActions>
        </Card>
    );
}