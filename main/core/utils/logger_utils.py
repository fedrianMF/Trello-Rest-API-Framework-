"""Module to manage loggers"""
import logging
import logging.config


class LoggerUtils:  # pylint: disable=R0903
    """Class defined to logger utils"""
    @staticmethod
    def config_logger(logger):
        """ Method to create logger with predefined configuration from logging.conf

        :param logger: name of logger from logging.conf
        :type logger: string
        """
        logging.config.fileConfig('logger.conf')
        return logging.getLogger(logger)
