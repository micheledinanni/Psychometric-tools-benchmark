import logging, datetime


def logger_file(e):
    now = datetime.datetime.now()
    logging.basicConfig(filename='../log/{0}.log'.format(now.strftime('%m-%d-%y-%H-%M-%S')), filemode='w',
                        format='%(name)s - %(levelname)s - %(message)s')
    return logging.error(e)
