/**
 * @providesModule Acknowledgements
 * @flow
 */

import * as React from 'react'
import styled from 'styled-components'

import { injectIntl, FormattedMessage } from 'react-intl'
import { Dialog, Button } from '@blueprintjs/core'

import type { IntlShape } from 'react-intl'

class Acknowledgements extends React.Component<
  { contents: string, intl: IntlShape },
  *
> {
  state = { isOpen: false }

  handleClick = () =>
    this.setState(({ isOpen }: $PropertyType<Acknowledgements, 'state'>) => ({
      isOpen: !isOpen,
    }))

  render () {
    const { contents, intl } = this.props
    if (!contents) return null
    const acknowledgements = intl.formatMessage({
      id: 'activerecord.attributes.case.acknowledgements',
    })
    return [
      <AcknowledgementsButton
        key="1"
        aria-label={acknowledgements}
        title={acknowledgements}
        onClick={this.handleClick}
      />,
      <Dialog
        key="2"
        title={acknowledgements}
        className="pt-dark"
        {...this.state}
        onClose={this.handleClick}
      >
        <div className="pt-dialog-body">
          <AcknowledgementsContents>{contents}</AcknowledgementsContents>
        </div>
        <div className="pt-dialog-footer">
          <div className="pt-dialog-footer-actions">
            <Button onClick={this.handleClick}>
              <FormattedMessage id="helpers.close" />
            </Button>
          </div>
        </div>
      </Dialog>,
    ]
  }
}
export default injectIntl(Acknowledgements)

const AcknowledgementsButton = styled(Button).attrs({
  className: 'pt-minimal pt-small',
  iconName: 'more',
})`
  margin-left: 0.25em;
`

const AcknowledgementsContents = styled.p.attrs({
  className: 'pt-running-text',
})`
  white-space: pre-wrap;
  margin: 0;
`
